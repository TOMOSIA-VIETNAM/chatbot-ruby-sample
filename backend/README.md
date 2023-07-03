**Other**
https://github.com/alexrudall/ruby-openai/issues/189
https://gist.github.com/lucasluitjes/0bf82de475ac91fe2ad8e71d5c2df164
https://community.openai.com/t/fine-tuning-in-a-nutshell-with-a-single-line-jsonl-file-and-n-epochs/60806

Sử dụng Gem OpenAI:
- https://blog.saeloun.com/2023/05/22/integrate-openai-api-in-ruby-application/
- https://github.com/alexrudall/ruby-openai

Coaching với Python: https://www.articulatepython.com/blog/finetune-openai-models

Tài liệu:
- https://platform.openai.com/docs/guides/fine-tuning/preparing-your-dataset
- https://platform.openai.com/docs/api-reference/completions/create

**Validation JSONL**

https://jsonlines.org/validator

```
openai tools fine_tunes.prepare_data -f data/training.jsonl
```

**File-tuning**

https://platform.openai.com/docs/guides/fine-tuning/preparing-your-dataset

Before:
```
File ID: file-aSQrjv1PKcMjxicGKuZPsG9k
Fine-tune ID: ft-3TCAkrSMKQMa9Jdn8SQpYHjf
Fine-tune: {"object"=>"fine-tune", "id"=>"ft-3TCAkrSMKQMa9Jdn8SQpYHjf", "hyperparams"=>{"n_epochs"=>4, "batch_size"=>nil, "prompt_loss_weight"=>0.01, "learning_rate_multiplier"=>nil}, "organization_id"=>"org-0fPskAhrzOrs5XH55S7rhsN0", "model"=>"ada", "training_files"=>[{"object"=>"file", "id"=>"file-aSQrjv1PKcMjxicGKuZPsG9k", "purpose"=>"fine-tune", "filename"=>"training.jsonl", "bytes"=>225784, "created_at"=>1686224799, "status"=>"uploaded", "status_details"=>nil}], "validation_files"=>[], "result_files"=>[], "created_at"=>1686224799, "updated_at"=>1686224799, "status"=>"pending", "fine_tuned_model"=>nil, "events"=>[{"object"=>"fine-tune-event", "level"=>"info", "message"=>"Created fine-tune: ft-3TCAkrSMKQMa9Jdn8SQpYHjf", "created_at"=>1686224799}]}
```

After:
```
Fine-tune: {"object"=>"fine-tune", "id"=>"ft-3TCAkrSMKQMa9Jdn8SQpYHjf", "hyperparams"=>{"n_epochs"=>4, "batch_size"=>1, "prompt_loss_weight"=>0.01, "learning_rate_multiplier"=>0.1}, "organization_id"=>"org-0fPskAhrzOrs5XH55S7rhsN0", "model"=>"ada", "training_files"=>[{"object"=>"file", "id"=>"file-aSQrjv1PKcMjxicGKuZPsG9k", "purpose"=>"fine-tune", "filename"=>"training.jsonl", "bytes"=>225784, "created_at"=>1686224799, "status"=>"processed", "status_details"=>nil}], "validation_files"=>[], "result_files"=>[], "created_at"=>1686224799, "updated_at"=>1686224930, "status"=>"running", "fine_tuned_model"=>nil, "events"=>[{"object"=>"fine-tune-event", "level"=>"info", "message"=>"Created fine-tune: ft-3TCAkrSMKQMa9Jdn8SQpYHjf", "created_at"=>1686224799}, {"object"=>"fine-tune-event", "level"=>"info", "message"=>"Fine-tune costs $0.23", "created_at"=>1686224874}, {"object"=>"fine-tune-event", "level"=>"info", "message"=>"Fine-tune enqueued. Queue number: 0", "created_at"=>1686224874}, {"object"=>"fine-tune-event", "level"=>"info", "message"=>"Fine-tune started", "created_at"=>1686224878}, {"object"=>"fine-tune-event", "level"=>"info", "message"=>"Completed epoch 1/4", "created_at"=>1686224930}]}
```

Done
```
Fine-tune: {"object"=>"fine-tune", "id"=>"ft-3TCAkrSMKQMa9Jdn8SQpYHjf", "hyperparams"=>{"n_epochs"=>4, "batch_size"=>1, "prompt_loss_weight"=>0.01, "learning_rate_multiplier"=>0.1}, "organization_id"=>"org-0fPskAhrzOrs5XH55S7rhsN0", "model"=>"ada", "training_files"=>[{"object"=>"file", "id"=>"file-aSQrjv1PKcMjxicGKuZPsG9k", "purpose"=>"fine-tune", "filename"=>"training.jsonl", "bytes"=>225784, "created_at"=>1686224799, "status"=>"processed", "status_details"=>nil}], "validation_files"=>[], "result_files"=>[{"object"=>"file", "id"=>"file-1Vxcun1QAwevhV3RR6onaOiR", "purpose"=>"fine-tune-results", "filename"=>"compiled_results.csv", "bytes"=>54771, "created_at"=>1686225063, "status"=>"processed", "status_details"=>nil}], "created_at"=>1686224799, "updated_at"=>1686225063, "status"=>"succeeded", "fine_tuned_model"=>"ada:ft-hinodeopenaiproject-2023-06-08-11-51-01", "events"=>[{"object"=>"fine-tune-event", "level"=>"info", "message"=>"Created fine-tune: ft-3TCAkrSMKQMa9Jdn8SQpYHjf", "created_at"=>1686224799}, {"object"=>"fine-tune-event", "level"=>"info", "message"=>"Fine-tune costs $0.23", "created_at"=>1686224874}, {"object"=>"fine-tune-event", "level"=>"info", "message"=>"Fine-tune enqueued. Queue number: 0", "created_at"=>1686224874}, {"object"=>"fine-tune-event", "level"=>"info", "message"=>"Fine-tune started", "created_at"=>1686224878}, {"object"=>"fine-tune-event", "level"=>"info", "message"=>"Completed epoch 1/4", "created_at"=>1686224930}, {"object"=>"fine-tune-event", "level"=>"info", "message"=>"Completed epoch 2/4", "created_at"=>1686224968}, {"object"=>"fine-tune-event", "level"=>"info", "message"=>"Completed epoch 3/4", "created_at"=>1686225006}, {"object"=>"fine-tune-event", "level"=>"info", "message"=>"Completed epoch 4/4", "created_at"=>1686225043}, {"object"=>"fine-tune-event", "level"=>"info", "message"=>"Uploaded model: ada:ft-hinodeopenaiproject-2023-06-08-11-51-01", "created_at"=>1686225062}, {"object"=>"fine-tune-event", "level"=>"info", "message"=>"Uploaded result file: file-1Vxcun1QAwevhV3RR6onaOiR", "created_at"=>1686225063}, {"object"=>"fine-tune-event", "level"=>"info", "message"=>"Fine-tune succeeded", "created_at"=>1686225063}]}
```
