from transformers import AutoConfig, AutoTokenizer
from optimum.intel.openvino import OVModelForCausalLM

model_dir = "neural-chat/INT8"
ov_model = OVModelForCausalLM.from_pretrained(model_dir, device="NPU")
tokenizer = AutoTokenizer.from_pretrained(model_dir)

prompt = "hi"

inputs = tokenizer(prompt, return_tensors="pt")
outputs = ov_model.generate(**inputs, max_new_tokens=256)

print(tokenizer.decode(outputs[0]))