const response = await fetch("http://localhost:8000/api/v1/library/books");

if (!response.ok) {
    throw new Error(`HTTP request failed with status ${response.status}`);
}

const body = await response.json();

if (body.success !== true) {
    throw new Error("API response success flag is not true");
}

if (!Array.isArray(body.data)) {
    throw new Error("API response data is not an array");
}

if (body.data.length !== 25) {
    throw new Error(`Expected 25 books, but received ${body.data.length}`);
}

const firstBook = body.data[0];

if (!firstBook.id || !firstBook.title || !firstBook.author) {
    throw new Error("First book is missing required fields");
}

console.log("Library books API test passed");
console.log(`Books returned: ${body.data.length}`);
console.log(`First book: ${firstBook.title}`);
