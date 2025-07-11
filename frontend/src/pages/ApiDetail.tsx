import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import type { ProcessedFileData, Endpoint } from '../types';
import ShowApiInfo from '../components/ApiInfo';
import EndpointList from '../components/EndpointList';
import EndpointDetail from '../components/EndpointDetail';
import { fetchProcessedFileData } from '../services/ApiService';

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
        fetchProcessedFileData(slug)
            .then((json) => {
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
            <button
                className="mb-6 px-4 py-2 bg-blue-600 text-white rounded shadow hover:bg-blue-700 transition-colors duration-200"
                onClick={() => window.location.href = '/'}
            >
                ← Back to Home
            </button>
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
