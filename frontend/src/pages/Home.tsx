import FileUpload from "../components/FileUpload";
import type { ProcessedFileData } from '../types.ts';
import { useState } from 'react';
import ApiDetail from './ApiDetail';

const App: React.FC = () => {
    const [apiData, setApiData] = useState<ProcessedFileData | null>(null);
    const handleFileProcessed = (data: ProcessedFileData): void => {
        setApiData(data);
    };

    return (
        <div className="flex justify-center items-center h-screen min-w-screen">
            {apiData ? (
                <ApiDetail data={apiData} />
            ) : (
                <FileUpload onFileProcessed={handleFileProcessed} />
            )}
        </div>
    );
}

export default App;
