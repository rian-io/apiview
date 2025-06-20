import { useEffect, useState } from 'react';

export default function Health() {
    const [status, setStatus] = useState<'checking' | 'ok' | 'fail'>('checking');

    useEffect(() => {
        fetch('api/v1/health')
            .then(res => res.ok ? setStatus('ok') : setStatus('fail'))
            .catch(() => setStatus('fail'));
    }, []);

    return (
        <div className="flex justify-center items-center h-screen min-w-screen bg-gray-50 dark:bg-gray-900  ">
            {status === 'checking' && <p className="text-blue-500">Checking...</p>}
            {status === 'ok' && <p className="text-green-600 font-bold">✅ Backend OK</p>}
            {status === 'fail' && <p className="text-red-600 font-bold">❌ Backend FAIL</p>}
        </div>
    );
}
