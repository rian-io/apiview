
// Define interfaces for API data structures
export interface ApiInfo {
  title?: string;
  version?: string;
  description?: string;
  slug?: string; // Added for file identification
  uploadedAt?: string; // Added for file upload timestamp
}

export interface Parameter {
  name: string;
  in: 'path' | 'query' | 'header' | 'cookie';
  description?: string;
  required?: boolean;
  schema?: any; // Using 'any' for simplicity, could be refined with OpenAPI schema types
  type?: string; // For OpenAPI v2 compatibility
}

export interface RequestBodyContent {
  [contentType: string]: {
    schema?: any; // Using 'any' for simplicity
  };
}

export interface RequestBody {
  description?: string;
  required?: boolean;
  content?: RequestBodyContent;
}

export interface ResponseContent extends RequestBodyContent { }

export interface Response {
  description: string;
  content?: ResponseContent;
  headers?: { [headerName: string]: any }; // Using 'any' for simplicity
}

export interface Responses {
  [statusCode: string]: Response;
}

export interface Endpoint {
  path: string;
  method: 'GET' | 'POST' | 'PUT' | 'DELETE' | 'PATCH' | 'OPTIONS' | 'HEAD';
  summary?: string;
  description?: string;
  operationId?: string;
  parameters?: Parameter[];
  requestBody?: RequestBody;
  responses?: Responses;
  tags?: string[];
}

export interface ApiData {
  info: ApiInfo;
  endpoints: Endpoint[];
  filename?: string; // Added from upload response
}

// Type for the data passed to handleFileProcessed in App.tsx
export interface ProcessedFileData extends ApiData {
  message?: string;
}

// Type for the data structure used in handleSaveAndShare in App.tsx
export interface SpecToSave {
  info: ApiInfo;
  paths: {
    [path: string]: {
      [method: string]: {
        summary?: string;
        description?: string;
        operationId?: string;
        parameters?: Parameter[];
        responses?: Responses;
        requestBody?: RequestBody;
      }
    }
  };
}

// Type for the save API response in App.tsx
export interface SaveApiResponse {
  id: string;
  title: string;
  link: string;
  expires_at: string;
  message: string;
}

// Type for the proxy API response in TestPanel.tsx
export interface ProxyResponse {
  status: number;
  statusText: string;
  headers: { [key: string]: string };
  data: any; // Response data can be anything
}
