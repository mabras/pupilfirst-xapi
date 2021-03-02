# Changelog

### 0.2.0 (02.03.2021)

+ Add: Allow to set LRS endpoint adapter by setting `PupilfirstXapi.lrs` module
  variable. If not set default one (`PupilfirstXapi::Lrs`) will be used.
  The LRS adapter must implement a `call` method with single argument of XAPI
  statement. The statement passed to LRS adapter could be `nil` and in this case
  it must not send it to LRS store.
  Useful in tests when you do not want any HTTP requests to be made. Just add
  your own LRS adapter.

### 0.1.0 (02.03.2021)

Initial release.
