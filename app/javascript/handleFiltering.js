function handleCategory(value) {
    if (value !== '') {
        window.location.pathname = "/spendings"
        window.location.search = `?filter=category&category=${value}`
    }
}