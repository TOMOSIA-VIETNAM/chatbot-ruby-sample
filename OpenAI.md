## Validation data

```
openai tools fine_tunes.prepare_data -f data/less-qlearsupport.csv
```

After you’ve fine-tuned a model, remember that your prompt has to end with the indicator string `\n\n###\n\n` for the model to start generating completions, rather than continuing with the prompt. Make sure to include `stop=[" END"]` so that the generated texts ends at the expected place.
Once your model starts training, it'll approximately take 3.8 minutes to train a `curie` model, and less for `ada` and `babbage`. Queue will approximately take half an hour per job ahead of you.
