import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import type { ProcessedFileData, Endpoint } from '../types';
import ShowApiInfo from '../components/ApiInfo';
import EndpointList from '../components/EndpointList';
import EndpointDetail from '../components/EndpointDetail';

const ApiDetail: React.FC = () => {
    const { slug } = useParams<{ slug: string }>();
    const [data, setData] = useState<ProcessedFileData | null>(null);
    const [selected, setSelected] = useState<Endpoint | null>(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        if (!slug) return;
        setLoading(true);
        setError(null);
        fetch(`/api/v1/view/${slug}`)
            .then(async (res) => {
                if (!res.ok) {
                    const err = await res.text();
                    throw new Error(err || 'Failed to load API details');
                }
                return res.json();
            })
            .then((json: ProcessedFileData) => {
                setData(json);
                setSelected(null);
            })
            .catch((err) => {
                setError(err.message || 'Failed to load API details');
            })
            .finally(() => setLoading(false));
    }, [slug]);

    if (loading) {
        return <div className="text-center py-12 text-gray-500">Loading...</div>;
    }
    if (error) {
        return <div className="text-center py-12 text-red-500">{error}</div>;
    }
    if (!data) {
        return null;
    }

    return (
        <div className="container mx-auto py-6">
            <ShowApiInfo info={data.info} />
            <div className="flex gap-8">
                <div className="w-1/3">
                    <EndpointList endpoints={data.endpoints} onSelect={setSelected} />
                </div>
                <div className="flex-1">
                    <EndpointDetail endpoint={selected} />
                </div>
            </div>
        </div>
    );
};

export default ApiDetail;
