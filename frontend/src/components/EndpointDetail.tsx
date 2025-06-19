import React from 'react';
import type { Endpoint } from '../types';

interface EndpointDetailProps {
    endpoint: Endpoint;
}

const EndpointDetail: React.FC<EndpointDetailProps> = ({ endpoint }) => (
    <div id="endpoint-detail-container" className="p-4">
        <h3 className="text-lg font-bold mb-2">{endpoint.method} {endpoint.path}</h3>
        <p className="mb-2 text-gray-700">{endpoint.summary || endpoint.operationId || 'No summary'}</p>
        <div className="mb-2"><strong>Description:</strong> {endpoint.description || '-'}</div>
        <div className="mb-2"><strong>Operation ID:</strong> {endpoint.operationId || '-'}</div>
        <div className="mb-2"><strong>Parameters:</strong> <pre>{JSON.stringify(endpoint.parameters, null, 2) || '-'}</pre></div>
        <div className="mb-2"><strong>Request Body:</strong> <pre>{JSON.stringify(endpoint.requestBody, null, 2) || '-'}</pre></div>
        <div className="mb-2"><strong>Responses:</strong> <pre>{JSON.stringify(endpoint.responses, null, 2) || '-'}</pre></div>
    </div>
);

export default EndpointDetail;
