import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Health from './pages/Health';
import Home from './pages/Home';

export default function App() {
  return (
    <BrowserRouter>
      <Routes>
        {/* Outras rotas aqui, como <Route path="/" element={<Home />} /> */}
        <Route path="/" element={<Home />} />
        {/* Rota para a página de saúde */}
        <Route path="/health" element={<Health />} />
      </Routes>
    </BrowserRouter>
  );
}
