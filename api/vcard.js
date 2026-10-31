// Devuelve un contacto (.vcf) como archivo real para que el celular muestre "Crear contacto nuevo".
// Recibe la tarjeta en base64url (?d=...). No guarda nada; valida que sea una tarjeta de contacto.
module.exports = (req, res) => {
  try {
    const d = String((req.query && req.query.d) || '')
    const texto = Buffer.from(d, 'base64url').toString('utf8')
    if (!texto.startsWith('BEGIN:VCARD') || !texto.includes('END:VCARD') || texto.length > 4000) {
      res.statusCode = 400; res.end('Contacto no válido'); return
    }
    res.setHeader('Content-Type', 'text/vcard; charset=utf-8')
    res.setHeader('Content-Disposition', 'inline; filename="contacto.vcf"')
    res.setHeader('Cache-Control', 'no-store')
    res.statusCode = 200; res.end(texto)
  } catch (e) { res.statusCode = 400; res.end('Contacto no válido') }
}
