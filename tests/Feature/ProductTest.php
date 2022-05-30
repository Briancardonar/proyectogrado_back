<?php

namespace Tests\Feature;

use App\Models\Product;
use Illuminate\Foundation\Testing\DatabaseMigrations;
use Tests\TestCase;

class ProductTest extends TestCase
{
    /**
     * A basic feature test example.
     *
     * @return void
     */
    public function testCreate()
    {
        $producto = Product::factory()->create();
        $productoDecode = json_decode($producto);
        $productoToArray = (array) $productoDecode;
        $response = $this->post('/api/producto', $productoToArray);
        $response->assertStatus(200);
    }

    public function testList()
    {
        $response = $this->get('/api/productos');
        $response->assertStatus(200);
    }

    public function testFind()
    {
        $producto = Product::all()->last();
        $response = $this->get('/api/producto/' . $producto->id);
        $response->assertStatus(200);
    }

    public function testUpdate()
    {
        $producto = Product::all()->last();
        $productoArray = (array) $producto;
        $productoData = $productoArray["\x00*\x00attributes"];
        $response = $this->put('/api/producto/' . $producto->id, $productoData);
        $response->assertStatus(200);
    }

    public function testDelete()
    {
        $producto = Product::all()->last();
        $productoArray = (array) $producto;
        $productoData = $productoArray["\x00*\x00attributes"];
        $response = $this->delete('/api/producto/' . $producto->id, $productoData);
        $response->assertStatus(200);
    }
}
