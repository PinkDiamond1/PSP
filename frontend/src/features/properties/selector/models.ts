export interface IMapProperty {
  pid?: string;
  pin?: string;
  latitude?: number;
  longitude?: number;
  planNumber?: string;
  address?: string;
  legalDescription?: string;
  region?: number;
  regionName?: string;
  district?: number;
  districtName?: string;
}

export interface ILayerSearchCriteria {
  pid?: string;
  pin?: string;
  planNumber?: string;
  legalDescription?: string;
  searchBy?: string;
}
