import { useEffect, useState } from 'react';
import { checkHealth } from '../services/ApiService';

export default function Health() {
    const [status, setStatus] = useState<'checking' | 'ok' | 'fail'>('checking');

    useEffect(() => {
        checkHealth()
            .then((ok) => setStatus(ok ? 'ok' : 'fail'))
            .catch(() => setStatus('fail'));
    }, []);

    return (
        <div className="flex justify-center items-center h-screen min-w-screen">
            {status === 'checking' && <p className="text-blue-500">Checking...</p>}
            {status === 'ok' && <p className="text-green-600 font-bold">✅ Backend OK</p>}
            {status === 'fail' && <p className="text-red-600 font-bold">❌ Backend FAIL</p>}
        </div>
    );
}
