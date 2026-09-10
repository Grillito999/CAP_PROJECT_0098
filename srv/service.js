const cds = require('@sap/cds');
const { SELECT } = require('@sap/cds/lib/ql/cds-ql');

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

        return super.init();
    }
}

module.exports = OrderItem;
