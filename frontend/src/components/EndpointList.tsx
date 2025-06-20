import React, { useState, useEffect } from 'react';
import type { Endpoint } from '../types';

const getMethodColor = (method: string) => {
    switch (method.toUpperCase()) {
        case 'GET': return 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-200';
        case 'POST': return 'bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-200';
        case 'PUT': return 'bg-yellow-100 text-yellow-800 dark:bg-yellow-900 dark:text-yellow-200';
        case 'DELETE': return 'bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-200';
        case 'PATCH': return 'bg-purple-100 text-purple-800 dark:bg-purple-900 dark:text-purple-200';
        default: return 'bg-gray-100 text-gray-800 dark:bg-gray-700 dark:text-gray-200';
    }
};

type Props = {
    endpoints: Endpoint[];
    onSelect: (endpoint: Endpoint) => void;
};

const EndpointList: React.FC<Props> = ({ endpoints, onSelect }) => {
    const [selectedKey, setSelectedKey] = useState<string | null>(null);
    const grouped = endpoints.reduce<Record<string, Endpoint[]>>((acc, ep) => {
        acc[ep.path] = acc[ep.path] || [];
        acc[ep.path].push(ep);
        return acc;
    }, {});

    // Select the first endpoint by default on mount or when endpoints change
    useEffect(() => {
        if (endpoints.length > 0) {
            const first = endpoints[0];
            const firstKey = first.method + first.path + '0';
            setSelectedKey(firstKey);
            onSelect(first);
        }
    }, [endpoints, onSelect]);

    const handleSelect = (endpoint: Endpoint, idx: number) => {
        setSelectedKey(endpoint.method + endpoint.path + idx);
        onSelect(endpoint);
    };

    return (
        <div id="endpoint-list-container" className="bg-white dark:bg-gray-800 rounded-lg shadow transition-colors duration-300">
            <div className="px-4 py-3 border-b border-gray-200 dark:border-gray-700">
                <h2 className="text-lg font-medium text-gray-800 dark:text-gray-100">API Endpoints</h2>
                <p className="text-sm text-gray-500 dark:text-gray-300 mt-1">{endpoints.length} endpoints found</p>
            </div>
            <div className="divide-y divide-gray-200 dark:divide-gray-700 max-h-[70vh] overflow-y-auto">
                {Object.entries(grouped).map(([path, pathEndpoints]) => (
                    <div key={path} className="px-4 py-2">
                        <div className="text-sm font-medium text-gray-700 dark:text-gray-200 mb-2 break-all">{path}</div>
                        <div className="space-y-2">
                            {pathEndpoints.map((endpoint, idx) => {
                                const key = endpoint.method + endpoint.path + idx;
                                const isSelected = selectedKey === key;
                                return (
                                    <div
                                        key={key}
                                        className={`flex items-center p-2 rounded-md cursor-pointer transition-colors border-2 ${isSelected ? 'border-gray-500 bg-gray-300 dark:bg-gray-700' : 'border-transparent hover:bg-gray-50 dark:hover:bg-gray-700'}`}
                                        onClick={() => handleSelect(endpoint, idx)}
                                    >
                                        <span className={`inline-flex items-center px-2.5 py-0.5 rounded-md text-xs font-medium mr-2 ${getMethodColor(endpoint.method)}`}>
                                            {endpoint.method}
                                        </span>
                                        <div className="flex-1 min-w-0">
                                            <p className="text-sm font-medium text-gray-900 dark:text-gray-100 truncate">
                                                {endpoint.summary || endpoint.operationId || 'Unnamed endpoint'}
                                            </p>
                                        </div>
                                    </div>
                                );
                            })}
                        </div>
                    </div>
                ))}
            </div>
        </div>
    );
};

export default EndpointList;
