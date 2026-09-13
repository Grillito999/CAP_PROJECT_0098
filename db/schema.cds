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

  headerID     : String(36)   @mandatory @readonly;
  email        : String       @mandatory @Communication.IsEmailAddress;
  firstName    : String(30)   @mandatory @assert.format:'^[a-zA-ZÀ-ÿ\s]+$' @assert.format.message: 'Invalid name. The name must contain only letters.';
  lastName     : String(30)   @mandatory @assert.format:'^[a-zA-ZÀ-ÿ\s]+$' @assert.format.message: 'Invalid Last name. The name must contain only letters.';
  country      : Country;
  createOn     : Date         @readonly;
  deliveryDate : DateTime;
  orderStatus  : Association to one status @mandatory;
  imageUrl     : String(255) @Core.IsURL @assert.format:'^https?:\/\/[^\s$.?#].[^\s]*$' @assert.format.message: 'Invalid URL';
  items        : Composition of many Item
                   on items.header = $self
}

entity Item : cuid {
  itemID           : String(36)      @mandatory  @readonly;
  name             : String(100)     @mandatory @assert.format: '^[a-zA-Z0-9 ]+$' @assert.format.message: 'Invalid name. The name must contain numbers or letters.';
  description      : String(255)     @assert.format: '^[a-zA-Z0-9 ]+$' @assert.format.message: 'Invalid description. The description must contain numbers or letters.';
  releaseDate      : Date;
  discontinuedDate : Date;
  price            : Decimal(13, 2)  @mandatory  @assert.range: [0.01, 99999999999.99];
  Currency         : Currency        @mandatory;
  height           : Decimal(7, 2)   @assert.range: [0, 999.99];
  width            : Decimal(7, 2)   @assert.range: [0, 999.99];
  depth            : Decimal(7, 2)   @assert.range: [0, 999.99];
  quantity         : Integer         @mandatory  @assert.range: [0, 999.99]  ;
  unitOfMeasure    : Association to one Unit @Common.IsUnit;
  header           : Association to one Header;
}

entity status : CodeList {

  key code        : String(20) enum {

        Confirmed = 'Confirmed order';
        Cancelled = 'Cancelled';
        Processing = 'In Progress';

      };

      criticality : Integer;

}

entity Unit : CodeList {

  key code : String(20);

}
