from transformers import AutoConfig, AutoTokenizer
from optimum.intel.openvino import OVModelForCasualLM

model_dir = "neural-chat/INT8"
ov_model = OVModelForCasualLM.from_pretrained(model_dir, device="CPU")
tokenizer = AutoTokenizer.from_pretrained(model_dir)

prompt = "how big is the sun?"

inputs = tokenizer(prompt, return_tensors="pt")
outputs = ov_model.generate(**inputs, max_new_tokens=256)

print(tokenizer.decode(outputs[0]), skip_special_tokens=True)