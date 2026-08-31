using {CAP_PROJECT as my} from '../db/schema.cds';

service CAP_PROJECT_SERVICE {

  @odata.draft.enabled
  entity Header as projection on my.Header;
  entity Item   as projection on my.Item;
  entity status as projection on my.status;
  
};
