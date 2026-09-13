using {CAP_PROJECT_SERVICE} from '../srv/service.cds';

annotate CAP_PROJECT_SERVICE.Header with @UI.HeaderInfo: {

  TypeName      : 'Sales Order',
  TypeNamePlural: 'Sales Orders',
  Title         : {Value: headerID}

};


annotate CAP_PROJECT_SERVICE.Header with {
  ID           @UI.HiddenFilter: true           @Consumption.filter.hidden: true;
  headerID     @title: 'ID';
  email        @title: 'Email';
  firstName    @title: 'First Name';
  lastName     @title: 'Last Name';
  country      @title: 'Country';
  createOn     @title: 'Created On';
  deliveryDate @title: 'Delivery Date';
  orderStatus  @title: 'Status';
  imageUrl     @title: 'Image URL';
  createdAt    @title          : 'Created At'   @UI.HiddenFilter          : true  @Consumption.filter.hidden: true;
  createdBy    @title          : 'Created By'   @UI.HiddenFilter          : true  @Consumption.filter.hidden: true;
  modifiedAt   @title          : 'Modified At'  @UI.HiddenFilter          : true  @Consumption.filter.hidden: true;
  modifiedBy   @title          : 'Modified By'  @UI.HiddenFilter          : true  @Consumption.filter.hidden: true;
};

annotate CAP_PROJECT_SERVICE.Header with @UI.SelectionFields: [
  headerID,
  email,
  firstName,
  lastName,
  country_code,
  orderStatus_code
];

annotate CAP_PROJECT_SERVICE.Header with {

  headerID  @(Common: {

  ValueList: {
    $Type         : 'Common.ValueListType',
    CollectionPath: 'Header',

    Parameters    : [
      {
        $Type            : 'Common.ValueListParameterInOut',
        LocalDataProperty: headerID,
        ValueListProperty: 'headerID',
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        LocalDataProperty: email,
        ValueListProperty: 'email',
      },

      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        LocalDataProperty: firstName,
        ValueListProperty: 'firstName',
      },

      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        LocalDataProperty: lastName,
        ValueListProperty: 'lastName',
      }

    ]
  },

  });

  email     @(Common: {

  ValueList: {
    $Type         : 'Common.ValueListType',
    CollectionPath: 'Header',

    Parameters    : [
      {
        $Type            : 'Common.ValueListParameterInOut',
        LocalDataProperty: email,
        ValueListProperty: 'email',
      },

      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        LocalDataProperty: firstName,
        ValueListProperty: 'firstName',
      },

      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        LocalDataProperty: lastName,
        ValueListProperty: 'lastName',
      }

    ]
  },

  });

  firstName @(Common: {

  ValueList: {
    $Type         : 'Common.ValueListType',
    CollectionPath: 'Header',

    Parameters    : [

      {
        $Type            : 'Common.ValueListParameterInOut',
        LocalDataProperty: firstName,
        ValueListProperty: 'firstName',
      },

      {
        $Type            : 'Common.ValueListParameterInOut',
        LocalDataProperty: lastName,
        ValueListProperty: 'lastName',
      },

      {
        $Type            : 'Common.ValueListParameterInOut',
        LocalDataProperty: email,
        ValueListProperty: 'email',
      }

    ]
  },

  });

  lastName  @(Common: {

  ValueList: {
    $Type         : 'Common.ValueListType',
    CollectionPath: 'Header',

    Parameters    : [

      {
        $Type            : 'Common.ValueListParameterInOut',
        LocalDataProperty: firstName,
        ValueListProperty: 'firstName',
      },

      {
        $Type            : 'Common.ValueListParameterInOut',
        LocalDataProperty: lastName,
        ValueListProperty: 'lastName',
      },

      {
        $Type            : 'Common.ValueListParameterInOut',
        LocalDataProperty: email,
        ValueListProperty: 'email',
      }

    ]
  },

  });


  country   @(Common: {

    Text     : country.name,

    ValueList: {
      $Type         : 'Common.ValueListType',
      CollectionPath: 'Countries',

      Parameters    : [

        {
          $Type            : 'Common.ValueListParameterInOut',
          LocalDataProperty: country_code,
          ValueListProperty: 'code',
        },

        {
          $Type            : 'Common.ValueListParameterDisplayOnly',
          LocalDataProperty: country_code,
          ValueListProperty: 'name',
        }

      ]
    },

  });


  orderStatus

            @Common.Text                    : orderStatus.name
            @Common.TextArrangement         : #TextOnly

            @Common.ValueListWithFixedValues: true // Se implementan las anotaciones de ValueListWithFixedValues para mostrar una lista de valores fijos en la aplicación FIOR

            @(Common: {

    ValueListWithFixedValue: true,

    ValueList              : {
      $Type         : 'Common.ValueListType',
      CollectionPath: 'status',
      Parameters    : [

      {
        $Type            : 'Common.ValueListParameterInOut',
        LocalDataProperty: orderStatus_code,
        ValueListProperty: 'code',
      }

      ]
    }

  });

};

annotate CAP_PROJECT_SERVICE.Header with @UI.LineItem: [

  {
    $Type     : 'UI.DataField',
    Value     : ID,
    @UI.Hidden: true
  },

  {
    $Type                : 'UI.DataField',
    Value                : headerID,
    ![@HTML5.CssDefaults]: {width: '6rem'}
  },
  {
    $Type                : 'UI.DataField',
    Value                : email,
    ![@HTML5.CssDefaults]: {width: '16rem'}
  },
  {
    $Type                : 'UI.DataField',
    Value                : firstName,
    ![@HTML5.CssDefaults]: {width: '10rem'}
  },
  {
    $Type                : 'UI.DataField',
    Value                : lastName,
    ![@HTML5.CssDefaults]: {width: '10rem'}
  },
  {
    $Type                : 'UI.DataField',
    Value                : country_code,
    ![@HTML5.CssDefaults]: {width: '8rem'}
  },
  {
    $Type: 'UI.DataField',
    Value: createOn
  },
  {
    $Type: 'UI.DataField',
    Value: deliveryDate
  },

  {
    $Type                : 'UI.DataField',
    Criticality          : orderStatus.criticality,
    Value                : orderStatus_code,
    ![@HTML5.CssDefaults]: {width: '10rem'}
  },

  {
    $Type: 'UI.DataField',
    Value: imageUrl
  },
  {
    $Type      : 'UI.DataFieldForAction',
    Action     : 'CAP_PROJECT_SERVICE.ApproveOrder',
    Criticality: 3,
    Label      : 'Approve order'

  },

  {
    $Type      : 'UI.DataFieldForAction',
    Action     : 'CAP_PROJECT_SERVICE.RejectOrder',
    Criticality: 1,
    Label      : 'Reject order'


  }
];

annotate CAP_PROJECT_SERVICE.Header with @UI.Identification: [

  {
    $Type: 'UI.DataField',
    Value: headerID,
  },
  {
    $Type: 'UI.DataField',
    Value: email,
  },
  {
    $Type: 'UI.DataField',
    Value: firstName
  },
  {
    $Type: 'UI.DataField',
    Value: lastName
  },
  {
    $Type: 'UI.DataField',
    Value: country_code
  },
  {
    $Type: 'UI.DataField',
    Value: createOn
  },
  {
    $Type: 'UI.DataField',
    Value: deliveryDate
  },
  {
    $Type      : 'UI.DataField',
    Value      : orderStatus_code,
    Criticality: orderStatus.criticality
  },
  {
    $Type: 'UI.DataField',
    Value: imageUrl
  },

  {
    $Type      : 'UI.DataFieldForAction',
    Action     : 'CAP_PROJECT_SERVICE.ApproveOrder',
    Criticality: 3,
    Label      : 'Approve order'

  },

  {
    $Type      : 'UI.DataFieldForAction',
    Action     : 'CAP_PROJECT_SERVICE.RejectOrder',
    Criticality: 1,
    Label      : 'Reject order'

  }

];

annotate CAP_PROJECT_SERVICE.Header with @UI.Facets: [
  {
    $Type : 'UI.ReferenceFacet',
    ID    : 'Main',
    Label : 'Product Information',
    Target: '@UI.Identification'
  },
  {
    $Type : 'UI.ReferenceFacet',
    ID    : 'SalesOrderItems',
    Label : 'Items',
    Target: 'items/@UI.LineItem'


  }
];

annotate CAP_PROJECT_SERVICE.Item with @UI.HeaderInfo: {
  TypeName      : 'Item',
  TypeNamePlural: 'Items',
  Title         : {Value: itemID}
};

annotate CAP_PROJECT_SERVICE.Item with {
  ID               @UI.Hidden;
  itemID           @title: 'ID';
  name             @title: 'Name';
  description      @title: 'Description'  @UI.MultiLineText;
  releaseDate      @title: 'Release Date';
  discontinuedDate @title: 'Discontinued Date';
  price            @title: 'Price'        @Measures.ISOCurrency: Currency_code;
  height           @title: 'Height'       @Measures.Unit       : unitOfMeasure_code;
  width            @title: 'Width'        @Measures.Unit       : unitOfMeasure_code;
  depth            @title: 'Depth'        @Measures.Unit       : unitOfMeasure_code;
  quantity         @title: 'Quantity';
  unitOfMeasure    @title: 'Unit Of Measure'

};


annotate CAP_PROJECT_SERVICE.Item with {

  itemID        @(Common: {

  ValueList: {
    $Type         : 'Common.ValueListType',
    CollectionPath: 'Item',

    Parameters    : [
      {
        $Type            : 'Common.ValueListParameterInOut',
        LocalDataProperty: itemID,
        ValueListProperty: 'itemID',
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        LocalDataProperty: name,
        ValueListProperty: 'name',
      },

      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        LocalDataProperty: description,
        ValueListProperty: 'description',
      },

    ]
  },

  });


  name          @(Common: {

  ValueList: {
    $Type         : 'Common.ValueListType',
    CollectionPath: 'Item',

    Parameters    : [
      {
        $Type            : 'Common.ValueListParameterInOut',
        LocalDataProperty: name,
        ValueListProperty: 'name',
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        LocalDataProperty: description,
        ValueListProperty: 'description',
      }

    ]
  },

  });

  unitOfMeasure @(Common: {

  ValueList: {
    $Type         : 'Common.ValueListType',
    CollectionPath: 'unit',

    Parameters    : [
      {


        $Type            : 'Common.ValueListParameterInOut',
        LocalDataProperty: unitOfMeasure_code,
        ValueListProperty: 'code',
      },

      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        LocalDataProperty: unitOfMeasure_code,
        ValueListProperty: 'name',
      },

      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        LocalDataProperty: unitOfMeasure_code,
        ValueListProperty: 'descr',
      }

    ]
  },

  });

};


annotate CAP_PROJECT_SERVICE.Item with @UI.Facets: [{
  $Type : 'UI.ReferenceFacet',
  ID    : 'Main',
  Label : 'Item Information',
  Target: '@UI.Identification'
}];

annotate CAP_PROJECT_SERVICE.Item with @UI.Identification: [
  {
    $Type: 'UI.DataField',
    Value: itemID,
  },
  {
    $Type: 'UI.DataField',
    Value: name
  },
  {
    $Type: 'UI.DataField',
    Value: description
  },
  {
    $Type: 'UI.DataField',
    Value: releaseDate
  },
  {
    $Type: 'UI.DataField',
    Value: discontinuedDate
  },
  {
    $Type: 'UI.DataField',
    Value: price
  },
  {
    $Type: 'UI.DataField',
    Value: height
  },
  {
    $Type: 'UI.DataField',
    Value: width
  },
  {
    $Type: 'UI.DataField',
    Value: depth
  },
  {
    $Type: 'UI.DataField',
    Value: quantity
  },
  {
    $Type: 'UI.DataField',
    Value: unitOfMeasure_code
  },

  {
    $Type : 'UI.DataFieldForAction',
    Action: 'CAP_PROJECT_SERVICE.setDiscount',
    Label : 'Discount'
  }

];

annotate CAP_PROJECT_SERVICE.Item with @UI.LineItem: [
  {
    $Type                : 'UI.DataField',
    Value                : itemID,
    ![@HTML5.CssDefaults]: {width: '8rem'}
  },
  {
    $Type                : 'UI.DataField',
    Value                : name,
    ![@HTML5.CssDefaults]: {width: '12rem'}
  },
  {
    $Type                : 'UI.DataField',
    Value                : description,
    ![@HTML5.CssDefaults]: {width: '12rem'}
  },
  {
    $Type                : 'UI.DataField',
    Value                : releaseDate,
    ![@HTML5.CssDefaults]: {width: '6rem'}

  },
  {
    $Type                : 'UI.DataField',
    Value                : discontinuedDate,
    ![@HTML5.CssDefaults]: {width: '6rem'}
  },
  {
    $Type                : 'UI.DataField',
    Value                : price,
    ![@HTML5.CssDefaults]: {width: '13rem'}
  },
  {
    $Type                : 'UI.DataField',
    Value                : height,
    ![@HTML5.CssDefaults]: {width: '15rem'}
  },
  {
    $Type                : 'UI.DataField',
    Value                : width,
    ![@HTML5.CssDefaults]: {width: '15rem'}
  },
  {
    $Type                : 'UI.DataField',
    Value                : depth,
    ![@HTML5.CssDefaults]: {width: '15rem'}
  },
  {
    $Type                : 'UI.DataField',
    Value                : quantity,
    ![@HTML5.CssDefaults]: {width: '15rem'}
  },
  {
    $Type                : 'UI.DataField',
    Value                : unitOfMeasure_code
  },
  {
    $Type : 'UI.DataFieldForAction',
    Action: 'CAP_PROJECT_SERVICE.setDiscount',
    Label : 'Discount'

  }
];

annotate CAP_PROJECT_SERVICE.status with {

  code @Common: {
    Text           : name,
    TextArrangement: #TextOnly
  }

};

annotate CAP_PROJECT_SERVICE.Dialog with {


  Discount  @Common: {Label: 'Discount percentage', }  @mandatory

};
