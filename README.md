###### Errors I Faced in whatsy app

# [RetrievalTimeoutHelper] Timed out waiting for SMS.
- enable Google Play Integrity API from [google cloud website].

# how to keep the same instance on both two screens?
- you must use [BlocProvider.value] to keep the same instance on both [LoginView] & [VerifyView]
  screens.

# unable to process request due to missing initial state. this may happen if browser session storages inaccessible or accidentally cleared.

# not preferred to use getIt with cubits it makes some errors. like it dose not close after page closed.
- if you use getIt with cubit it will not be closed until the app is closed.