import FileUpload from "../components/FileUpload";
import type { ProcessedFileData } from '../types.ts';

const App: React.FC = () => {
    const handleFileProcessed = (data: ProcessedFileData): void => {
        console.log("File processed successfully: ", data);
    };

    return (
        <div className="flex justify-center items-center h-screen min-w-screen">
            <FileUpload onFileProcessed={handleFileProcessed} />
        </div>
    );
}

export default App;
