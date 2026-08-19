namespace CAP_PROJECT;

using {
  cuid,
  managed,
  Currency,
  sap.common.CodeList
} from '@sap/cds/common';

@assert.unique: {headerID: [headerID]}

entity Header : cuid, managed {

  headerID     : String(36) @mandatory;
  email        : String     @mandatory  @assert.format: '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'  @Communication.IsEmailAddress;
  firstName    : String(30);
  lastName     : String(30);
  country      : String(30);
  createOn     : Date;
  deliveryDate : DateTime;
  orderStatus  : Association to one status;
  imageUrl     : String(255);
  items        : Composition of many Item
                   on items.header = $self


}

@assert.unique: {itemID: [itemID]}

entity Item : cuid {
  itemID           : String(36) @mandatory;
  name             : String(100);
  description      : String(255);
  releaseDate      : Date;
  discontinuedDate : Date;
  price            : Decimal(13, 2);
  Currency         : Currency;
  height           : Decimal(7, 2);
  width            : Decimal(7, 2);
  depth            : Decimal(7, 2);
  quantity         : Integer;
  unitOfMeasure    : String(20);
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
