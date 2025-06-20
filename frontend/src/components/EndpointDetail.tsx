import React from 'react';
import type { Endpoint } from '../types';

interface EndpointDetailProps {
    endpoint: Endpoint;
}

const EndpointDetail: React.FC<EndpointDetailProps> = ({ endpoint }) => (
    <div id="endpoint-detail-container" className="p-4 bg-white dark:bg-gray-800 rounded-lg shadow transition-colors duration-300">
        <h3 className="text-lg font-bold mb-2 text-gray-900 dark:text-gray-100">{endpoint.method} {endpoint.path}</h3>
        <p className="mb-2 text-gray-700 dark:text-gray-200">{endpoint.summary || endpoint.operationId || 'No summary'}</p>
        <div className="mb-2 text-gray-800 dark:text-gray-200"><strong>Description:</strong> {endpoint.description || '-'}</div>
        <div className="mb-2 text-gray-800 dark:text-gray-200"><strong>Operation ID:</strong> {endpoint.operationId || '-'}</div>
        <div className="mb-2 text-gray-800 dark:text-gray-200"><strong>Parameters:</strong> <pre className="bg-gray-100 dark:bg-gray-900 rounded p-2 overflow-x-auto">{JSON.stringify(endpoint.parameters, null, 2) || '-'}</pre></div>
        <div className="mb-2 text-gray-800 dark:text-gray-200"><strong>Request Body:</strong> <pre className="bg-gray-100 dark:bg-gray-900 rounded p-2 overflow-x-auto">{JSON.stringify(endpoint.requestBody, null, 2) || '-'}</pre></div>
        <div className="mb-2 text-gray-800 dark:text-gray-200"><strong>Responses:</strong> <pre className="bg-gray-100 dark:bg-gray-900 rounded p-2 overflow-x-auto">{JSON.stringify(endpoint.responses, null, 2) || '-'}</pre></div>
    </div>
);

export default EndpointDetail;
