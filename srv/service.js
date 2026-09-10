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

        return super.init();
    }
}

module.exports = OrderItem;
