import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Health from './pages/Health';

export default function App() {
  return (
    <BrowserRouter>
      <Routes>
        {/* Outras rotas aqui, como <Route path="/" element={<Home />} /> */}
        <Route path="/health" element={<Health />} />
      </Routes>
    </BrowserRouter>
  );
}
