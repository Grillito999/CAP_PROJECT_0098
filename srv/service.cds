using {CAP_PROJECT as my} from '../db/schema.cds';

service CAP_PROJECT_SERVICE {


type Dialog { // ventana descuento
  @assert.range: [0, 100]  // <-- Esta anotación restringe el valor entre 0 y 100
  Discount : Integer;
};

  @odata.draft.enabled
  entity Header as projection on my.Header;

  entity Item   as projection on my.Item

    actions {

      action setDiscount(

      Discount: Dialog:Discount
      
      )

    };

  entity status as projection on my.status;
  entity Unit   as projection on my.Unit;

};
