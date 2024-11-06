use shiva::core::TransformerTrait;

fn main() {
    let file_start = "/home/connor/Documents/coding/rust_projects/ma_2_pdf/testfile/Safe/";
    let xml_file = String::from(file_start.to_owned() + "testing.xml");
    let pdf_file = String::from(file_start.to_owned() + "out.md");
    
    
    let input_vec = std::fs::read(xml_file).unwrap();
    let input_bytes = bytes::Bytes::from(input_vec);
    let document = shiva::xml::Transformer::parse(&input_bytes).unwrap();
    let output_bytes = shiva::pdf::Transformer::generate(&document).unwrap();

    std::fs::write(pdf_file, output_bytes).unwrap();
}
