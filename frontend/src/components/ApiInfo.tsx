import React from 'react';
import type { ApiInfo } from '../types';

interface ApiInfoProps {
    info: ApiInfo;
}

const ShowApiInfo: React.FC<ApiInfoProps> = ({ info }) => (
    <div className="mb-6 bg-white dark:bg-gray-800 rounded-lg p-4 shadow transition-colors duration-300">
        <h1 id="api-title" className="text-2xl font-bold mb-2 text-gray-900 dark:text-gray-100">{info.title}</h1>
        <div id="api-version" className="text-sm text-gray-500 dark:text-gray-300 mb-2">{info.version && `v${info.version}`}</div>
        <div id="api-description" className="mb-2 text-gray-700 dark:text-gray-200">
            <p>{info.description}</p>
        </div>
    </div>
);

export default ShowApiInfo;
