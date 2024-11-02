use shiva::core::TransformerTrait;

fn main() {
    let xml_file = "/home/connor/Documents/coding/rust_projects/ma_2_pdf/testfile/Safe/testing.xml";
    let pdf_file = "/home/connor/Documents/coding/rust_projects/ma_2_pdf/testfile/Safe/out.md";
    
    
    let input_vec = std::fs::read(xml_file).unwrap();
    let input_bytes = bytes::Bytes::from(input_vec);
    let document = shiva::xml::Transformer::parse(&input_bytes).unwrap();
    let output_bytes = shiva::html::Transformer::generate(&document).unwrap();

    std::fs::write(pdf_file, output_bytes).unwrap();
}
