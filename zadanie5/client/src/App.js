import { BrowserRouter, Routes, Route, Link } from 'react-router-dom'
import Products from './components/Products'
import Payments from './components/Payments'
import Cart from './components/Cart'

function App() {
  return (
    <BrowserRouter>
      <div className="App">
        <h1>Mój Sklep</h1>
        <nav>
          <Link to="/">Produkty</Link> |{' '}
          <Link to="/cart">Koszyk</Link> |{' '}
          <Link to="/payments">Płatności</Link>
        </nav>
        <Routes>
          <Route path="/" element={<Products />} />
          <Route path="/cart" element={<Cart />} />
          <Route path="/payments" element={<Payments />} />
        </Routes>
      </div>
    </BrowserRouter>
  )
}

export default App
