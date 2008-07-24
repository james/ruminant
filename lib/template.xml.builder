xml.instruct!
xml.moo("xsi:noNamespaceSchemaLocation" => "http://www.moo.com/xsd/api_0.7.xsd", "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance") {
  xml.request {
    xml.version self.api_version
    xml.api_key self.api_key
    xml.call "build"
  }
  xml.payload{
    xml.products {
      xml.product {
        xml.product_type self.product_type
        xml.designs {
          self.designs.each { |design|
            design.to_xml(xml)
          }
        }
      }
    }
  }
}