import debounce from 'lodash/debounce'

export function readFormElements(form) {
  const elements = form.elements
  let values = {}
  for (let i = 0; i < elements.length; i += 1) {
    let field = elements[i]
    const value = (field.type === 'checkbox') ? field.checked : field.value
    values[field.name] = value
  }
  return values
}

export function whenFormElementsChange(form, { debounceBy }, handler) {
  const debouncedFunc = debounce(event => {
    const values = readFormElements(form)
    handler(values, form)
  }, debounceBy)

  form.addEventListener('input', debouncedFunc)
  form.addEventListener('blur', debouncedFunc)

  return debouncedFunc
}