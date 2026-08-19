using {CAP_PROJECT_SERVICE} from '../srv/service.cds';

annotate CAP_PROJECT_SERVICE.Header with @UI.HeaderInfo: {

  TypeName      : 'Sales Order',
  TypeNamePlural: 'Sales Orders',
  Title         : {Value: headerID}

};

annotate CAP_PROJECT_SERVICE.status with {

  code @(

    Common.Label          : 'Status',
    Common.Text           : name,
    Common.TextArrangement: #TextOnly
  );

};

annotate CAP_PROJECT_SERVICE.Header with {
  ID           @UI.HiddenFilter: true  @Consumption.filter.hidden: true;
  headerID     @title: 'Product';
  email        @title: 'Email';
  firstName    @title: 'First Name';
  lastName     @title: 'Last Name';
  country      @title: 'Country';
  createOn     @title: 'Created On';
  deliveryDate @title: 'Delivery Date';
  orderStatus  @title: 'Status';
  imageUrl     @title: 'Image URL';
  createdAt    @title: 'Created At';
  createdBy    @title: 'Created By';
  modifiedAt   @title: 'Modified At';
  modifiedBy   @title: 'Modified By'
};

annotate CAP_PROJECT_SERVICE.Header with @UI.SelectionFields: [
  headerID,
  email,
  firstName,
  lastName,
  country,
  orderStatus_code
];

annotate CAP_PROJECT_SERVICE.Header with {

  headerID    @(Common: {

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
        $Type            : 'Common.ValueListParameterInOut',
        LocalDataProperty: email,
        ValueListProperty: 'email',
      },

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
        LocalDataProperty: country,
        ValueListProperty: 'country',
      }

    ]
  },

  });

  email       @(Common: {

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
        $Type            : 'Common.ValueListParameterInOut',
        LocalDataProperty: firstName,
        ValueListProperty: 'firstName',
      },

      {
        $Type            : 'Common.ValueListParameterInOut',
        LocalDataProperty: lastName,
        ValueListProperty: 'lastName',
      }

    ]
  },

  });

  firstName   @(Common: {

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
      },

      {
        $Type            : 'Common.ValueListParameterInOut',
        LocalDataProperty: country,
        ValueListProperty: 'country',
      }

    ]
  },

  });

  lastName    @(Common: {

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
      },

      {
        $Type            : 'Common.ValueListParameterInOut',
        LocalDataProperty: country,
        ValueListProperty: 'country',
      }

    ]
  },

  });


  country     @(Common: {

  ValueList: {
    $Type         : 'Common.ValueListType',
    CollectionPath: 'Header',

    Parameters    : [

    {
      $Type            : 'Common.ValueListParameterInOut',
      LocalDataProperty: country,
      ValueListProperty: 'country',
    }

    ]
  },

  });


  orderStatus @Common.ValueListWithFixedValues: true // Se implementan las anotaciones de ValueListWithFixedValues para mostrar una lista de valores fijos en la aplicación FIOR
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
    Value                : country,
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
    Value                : orderStatus.code,
    ![@HTML5.CssDefaults]: {width: '10rem'}
  },

  {
    $Type     : 'UI.DataField',
    Value     : orderStatus_code,
    @UI.Hidden: true
  },

  {
    $Type: 'UI.DataField',
    Value: imageUrl
  }
];

annotate CAP_PROJECT_SERVICE.Header with @UI.FieldGroup #Main: {

  $Type: 'UI.FieldGroupType',
  Data : [
    {
      $Type: 'UI.DataField',
      Value: headerID
    },
    {
      $Type: 'UI.DataField',
      Value: email
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
      Value: country
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
      Criticality: orderStatus.criticality,
      Value      : orderStatus.code
    },
    {
      $Type: 'UI.DataField',
      Value: imageUrl
    },
    {
      $Type: 'UI.DataField',
      Value: createdAt
    },
    {
      $Type: 'UI.DataField',
      Value: createdBy
    },
    {
      $Type: 'UI.DataField',
      Value: modifiedAt
    },
    {
      $Type: 'UI.DataField',
      Value: modifiedBy
    }
  ]
};

annotate CAP_PROJECT_SERVICE.Header with @UI.Facets: [
  {
    $Type : 'UI.ReferenceFacet',
    ID    : 'Main',
    Label : 'Product Information',
    Target: '@UI.FieldGroup#Main'
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
  ID  @UI.Hidden  @Common.Text: {
    $value                : itemID,
    ![@UI.TextArrangement]: #TextOnly
  }
};

// annotate CAP_PROJECT_SERVICE.Item with @UI.Identification: [{Value: itemID}];

annotate CAP_PROJECT_SERVICE.Item with {
  itemID           @title: 'ID';
  name             @title: 'Name';
  description      @title: 'Description';
  releaseDate      @title: 'Release Date';
  discontinuedDate @title: 'Discontinued Date';
  price            @title: 'Price';
  height           @title: 'Height';
  width            @title: 'Width';
  depth            @title: 'Depth';
  quantity         @title: 'Quantity';
  unitOfMeasure    @title: 'Unit Of Measure'
};

annotate CAP_PROJECT_SERVICE.Item with {
  price @Measures.ISOCurrency: Currency_code
};

annotate CAP_PROJECT_SERVICE.Item with @UI.LineItem: [
  {
    $Type: 'UI.DataField',
    Value: itemID
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
    Value: unitOfMeasure
  }
];

annotate CAP_PROJECT_SERVICE.Item with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType',
  Data : [
    {
      $Type: 'UI.DataField',
      Value: itemID
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
      Value: unitOfMeasure
    }
  ]
};

annotate CAP_PROJECT_SERVICE.Item with {
  header @Common.Text: {
    $value                : itemID,
    ![@UI.TextArrangement]: #TextOnly
  }
};

annotate CAP_PROJECT_SERVICE.Item with {
  header @Common.Label: 'Header'
};

annotate CAP_PROJECT_SERVICE.Item with @UI.Facets: [{
  $Type : 'UI.ReferenceFacet',
  ID    : 'Main',
  Label : 'Item Information',
  Target: '@UI.FieldGroup#Main'
}];

annotate CAP_PROJECT_SERVICE.Item with @UI.SelectionFields: [itemID];
