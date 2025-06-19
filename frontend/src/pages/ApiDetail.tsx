import React, { useState } from 'react';
import type { ProcessedFileData, Endpoint } from '../types';
import ShowApiInfo from '../components/ApiInfo';
import EndpointList from '../components/EndpointList';
import EndpointDetail from '../components/EndpointDetail';

interface ApiDetailProps {
    data: ProcessedFileData;
}

const ApiDetail: React.FC<ApiDetailProps> = ({ data }) => {
    const [selected, setSelected] = useState<Endpoint | null>(data.endpoints[0] || null);

    return (
        <div className="container mx-auto py-6">
            <ShowApiInfo info={data.info} />
            <div className="flex gap-8">
                <div className="w-1/3">
                    <EndpointList endpoints={data.endpoints} onSelect={setSelected} />
                </div>
                <div className="flex-1">
                    {selected && <EndpointDetail endpoint={selected} />}
                </div>
            </div>
        </div>
    );
};

export default ApiDetail;
