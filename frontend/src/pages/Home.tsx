import FileUpload from "../components/FileUpload";

const App: React.FC = () => {
    return (
        <div className="flex justify-center items-center h-screen min-w-screen bg-gray-50 dark:bg-gray-900 transition-colors duration-300">
            <FileUpload />
        </div>
    );
}

export default App;
