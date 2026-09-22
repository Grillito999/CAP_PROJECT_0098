const cds = require('@sap/cds');
const { SELECT } = require('@sap/cds/lib/ql/cds-ql');
const { header } = require('express/lib/request');

class OrderItem extends cds.ApplicationService {
    init() {

        const { Header } = this.entities;


        this.before("NEW", Header.drafts, async (req) => {

            const fechaActual = new Date().toISOString().split('T')[0];

            req.data.createOn = fechaActual;
        });

        this.before("NEW", Header.drafts, async (req) => {

            let result = await SELECT.one.from(Header).columns('max(headerID) as id');
            let result2 = await SELECT.one.from(Header.drafts).columns('max(headerID) as id');
            let max = result && result.id ? parseInt(result.id, 10) : 0;
            let max2 = result2 && result2.id ? parseInt(result2.id, 10) : 0;

            let currentMax = Math.max(max, max2);

            let newmax = currentMax > 0 ? currentMax + 1 : 100000;

            req.data.headerID = newmax;
        });

        const { Item } = this.entities;

        this.before("NEW", Item.drafts, async (req) => {

            let result = await SELECT.one.from(Item.drafts).columns('max(itemID) as id');
            let max = result.id ? parseInt(result.id, 10) : 0;

            let currentMax = Math.max(max);

            let newmax = currentMax > 0 ? currentMax + 1 : 1;

            req.data.itemID = newmax;
        });

        this.on("setDiscount", async (req) => {

            const discount = req.data.Discount;

            if (discount < 0 || discount > 100) {

                return req.reject(400, 'El descuento debe ser un valor entre 0 y 100.');
            }

            let item = await SELECT.one.from(req.subject).columns('price');

            let newValue = item.price - (item.price * (discount / 100));

            await UPDATE(req.subject).with({
                price: newValue
            });

            req.info(200, `Descuento del ${discount}% aplicado. Nuevo precio: ${newValue}`);
        });

        this.on("ApproveOrder", async (req) => {
            const STATUS_PROCESSING = 'Processing';
            const STATUS_CONFIRMED = 'Confirmed';

            // 1. Leer el registro actual de la base de datos
            const order = await SELECT.one(req.subject).columns('orderStatus_code');

            // 2. Validar que la orden exista (buena práctica)
            if (!order) {
                return req.reject(404, 'Orden no encontrada');
            }

            // 3. Validar el estado (usamos !== que es más seguro en Javascript)
            if (order.orderStatus_code !== STATUS_PROCESSING) {
                return req.reject(400, 'No se puede modificar una orden que ya fue aprobada o rechazada');
            }

            // 4. Actualizar el estado en la base de datos (usando el sufijo _code)
            await UPDATE(req.subject).with({
                orderStatus_code: STATUS_CONFIRMED
            });

            // 5. Enviar respuesta de éxito
            req.info(200, `Order approved`);
        });

 this.on("RejectOrder", async (req) => {
            const STATUS_PROCESSING = 'Processing';
            const STATUS_CANCELLED = 'Cancelled';

            // 1. Leer el registro actual de la base de datos
            const order = await SELECT.one(req.subject).columns('orderStatus_code');

            // 2. Validar que la orden exista (buena práctica)
            if (!order) {
                return req.reject(404, 'Orden no encontrada');
            }

            // 3. Validar el estado (usamos !== que es más seguro en Javascript)
            if (order.orderStatus_code !== STATUS_PROCESSING) {
                return req.reject(400, 'No se puede modificar una orden que ya fue aprobada o rechazada');
            }

            // 4. Actualizar el estado en la base de datos (usando el sufijo _code)
            await UPDATE(req.subject).with({
                orderStatus_code: STATUS_CANCELLED
            });

            // 5. Enviar respuesta de éxito
            req.info( 200, `Order cancelled`);
        });

        return super.init();
    }
}

module.exports = OrderItem;
