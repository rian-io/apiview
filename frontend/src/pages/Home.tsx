import React, { useState, useEffect } from "react";
import FileUpload from "../components/FileUpload";
import type { ApiInfo } from "../types";

const App: React.FC = () => {
    const [showModal, setShowModal] = useState(false);
    const [files, setFiles] = useState<ApiInfo[]>([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        fetch("/api/v1/view")
            .then(async (res) => {
                if (!res.ok) throw new Error(await res.text() || "Failed to load files");
                return res.json();
            })
            .then((data: ApiInfo[]) => {
                setFiles(data);
                setError(null);
            })
            .catch((err) => setError(err.message || "Failed to load files"))
            .finally(() => setLoading(false));
    }, []);

    return (
        <div className="flex flex-col items-center min-h-screen min-w-screen pt-12 bg-transparent">
            <button
                className="mb-8 px-6 py-3 bg-blue-600 text-white rounded-lg shadow hover:bg-blue-700 transition-colors duration-200 cursor-pointer"
                onClick={() => setShowModal(true)}
            >
                Upload API File
            </button>
            {showModal && (
                <div className="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-40">
                    <div className="bg-white dark:bg-gray-900 rounded-lg shadow-lg p-6 relative w-full max-w-2xl">
                        <button
                            className="absolute top-2 right-2 text-gray-500 hover:text-gray-800 dark:hover:text-gray-200 text-2xl font-bold cursor-pointer"
                            onClick={() => setShowModal(false)}
                            aria-label="Close"
                        >
                            &times;
                        </button>
                        <FileUpload />
                    </div>
                </div>
            )}
            <div className="w-full max-w-2xl mt-2">
                <h2 className="text-xl font-semibold mb-4 text-gray-800 dark:text-gray-100">Uploaded API Files</h2>
                {loading ? (
                    <div className="text-gray-500 text-center py-8">Loading...</div>
                ) : error ? (
                    <div className="text-red-500 text-center py-8">{error}</div>
                ) : files.length === 0 ? (
                    <div className="text-gray-400 text-center py-8">No files uploaded yet.</div>
                ) : (
                    <ul className="divide-y divide-gray-200 dark:divide-gray-700">
                        {files.map((file) => (
                            <li key={file.slug} className="py-3 flex items-center justify-between">
                                <div>
                                    <a
                                        href={`/view/${file.slug}`}
                                        className="text-blue-600 dark:text-blue-400 hover:underline font-medium"
                                    >
                                        {file.title || file.slug}
                                    </a>
                                    {file.uploadedAt && (
                                        <span className="ml-2 text-xs text-gray-500 dark:text-gray-400">{new Date(file.uploadedAt).toLocaleString()}</span>
                                    )}
                                </div>
                                <span className="text-xs text-gray-400">slug: {file.slug}</span>
                            </li>
                        ))}
                    </ul>
                )}
            </div>
        </div>
    );
}

export default App;
