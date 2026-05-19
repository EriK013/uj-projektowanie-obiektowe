import { useState, useEffect, useContext } from 'react';
import { CartContext } from '../App';

function Products() {
  const [products, setProducts] = useState([]);
  const { addToCart } = useContext(CartContext);

  useEffect(() => {
    fetch('http://localhost:8080/products')
      .then(res => res.json())
      .then(data => setProducts(data))
      .catch(err => console.error("Błąd pobierania:", err));
  }, []);

  return (
    <div>
      <h2>Nasze Produkty</h2>
      <ul>
        {products.map(p => (
          <li key={p.id}>
            {p.name} - {p.price} PLN
            <button onClick={() => addToCart(p)}>Dodaj do koszyka</button>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default Products;
