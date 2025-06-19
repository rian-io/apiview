import React from 'react';
import type { Endpoint } from '../types';

const getMethodColor = (method: string) => {
    switch (method.toUpperCase()) {
        case 'GET': return 'bg-green-100 text-green-800';
        case 'POST': return 'bg-blue-100 text-blue-800';
        case 'PUT': return 'bg-yellow-100 text-yellow-800';
        case 'DELETE': return 'bg-red-100 text-red-800';
        case 'PATCH': return 'bg-purple-100 text-purple-800';
        default: return 'bg-gray-100 text-gray-800';
    }
};

type Props = {
    endpoints: Endpoint[];
    onSelect: (endpoint: Endpoint) => void;
};

const EndpointList: React.FC<Props> = ({ endpoints, onSelect }) => {
    const grouped = endpoints.reduce<Record<string, Endpoint[]>>((acc, ep) => {
        acc[ep.path] = acc[ep.path] || [];
        acc[ep.path].push(ep);
        return acc;
    }, {});

    return (
        <div id="endpoint-list-container">
            <div className="px-4 py-3 border-b border-gray-200">
                <h2 className="text-lg font-medium text-gray-800">API Endpoints</h2>
                <p className="text-sm text-gray-500 mt-1">{endpoints.length} endpoints found</p>
            </div>
            <div className="divide-y divide-gray-200 max-h-[70vh] overflow-y-auto">
                {Object.entries(grouped).map(([path, pathEndpoints]) => (
                    <div key={path} className="px-4 py-2">
                        <div className="text-sm font-medium text-gray-700 mb-2 break-all">{path}</div>
                        <div className="space-y-2">
                            {pathEndpoints.map((endpoint, idx) => (
                                <div
                                    key={endpoint.method + endpoint.path + idx}
                                    className="flex items-center p-2 rounded-md cursor-pointer transition-colors hover:bg-gray-50"
                                    onClick={() => onSelect(endpoint)}
                                >
                                    <span className={`inline-flex items-center px-2.5 py-0.5 rounded-md text-xs font-medium mr-2 ${getMethodColor(endpoint.method)}`}>
                                        {endpoint.method}
                                    </span>
                                    <div className="flex-1 min-w-0">
                                        <p className="text-sm font-medium text-gray-900 truncate">
                                            {endpoint.summary || endpoint.operationId || 'Unnamed endpoint'}
                                        </p>
                                    </div>
                                </div>
                            ))}
                        </div>
                    </div>
                ))}
            </div>
        </div>
    );
};

export default EndpointList;
