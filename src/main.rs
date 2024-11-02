use shiva::core::TransformerTrait;

fn main() {
    let input_vec = std::fs::read("input.html").unwrap();
    let input_bytes = bytes::Bytes::from(input_vec);
    let document = shiva::html::Transformer::parse(&input_bytes).unwrap();
    let output_bytes = shiva::markdown::Transformer::generate(&document).unwrap();
    std::fs::write("out.md", output_bytes).unwrap();
}


