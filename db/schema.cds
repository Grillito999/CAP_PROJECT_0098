namespace CAP_PROJECT;


using {
  cuid,
  managed,
  Currency,
  Country,
  sap.common.CodeList
} from '@sap/cds/common';

@assert.unique: {headerID: [headerID]}

entity Header : cuid, managed {

  headerID     : String(36)  @mandatory @readonly;
  email        : String      @mandatory  @assert.format: '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'  @Communication.IsEmailAddress;
  firstName    : String(30)  @mandatory;
  lastName     : String(30);
  country      : Country;
  createOn     : Date;
  deliveryDate : DateTime;
  orderStatus  : Association to one status;
  imageUrl     : String(255);
  items        : Composition of many Item
                   on items.header = $self
}

@assert.unique: {itemID: [itemID]}
entity Item : cuid {
  itemID           : String(36)     @mandatory @readonly;
  name             : String(100);
  description      : String(255);
  releaseDate      : Date;
  discontinuedDate : Date;
  price            : Decimal(13, 2) @mandatory;
  Currency         : Currency       @mandatory;
  height           : Decimal(7, 2);
  width            : Decimal(7, 2);
  depth            : Decimal(7, 2);
  quantity         : Integer        @mandatory;
  unitOfMeasure    : String(20)     @Common.IsUnit;
  header           : Association to one Header;
}

entity status : CodeList {

  key code        : String(20) enum {

        inStock = 'In Stock';
        OutOfStock = ' Not In Stock';
        lowAvailability = 'Low Availability';

      };

      criticality : Integer;

}
