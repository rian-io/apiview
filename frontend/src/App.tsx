import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Health from './pages/Health';
import Home from './pages/Home';
import ApiDetail from './pages/ApiDetail';

export default function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/health" element={<Health />} />
        <Route path="/view/:slug" element={<ApiDetail />} />
      </Routes>
    </BrowserRouter>
  );
}
