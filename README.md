###### Errors I Faced in whatsy app

# No sms message came to check the number.
- enable Google Play Integrity API from [google cloud website].

# how to keep the same instance on both two screens?
- you must use [BlocProvider.value] to keep the same instance on both [LoginView] & [VerifyView]
  screens.

# unable to process request due to missing initial state. this may happen if browser session storages inaccessible or accidentally cleared.

# not preferred to use getIt with cubits it makes some errors. like it dose not close after page closed.
- if you use getIt with cubit it will not be closed until the app is closed.

## I learned another way to pass argument when navigate pop.
- 1st: Uint8List? galleryImg;
- 2nd: when navigate to PageA, await Navigator.push(context, MaterialPageRoute((context) {}))
  .then((value) {value != null ? galleryImg = value : null});

### مشكله ان الصوره الي بتخترها من المعرض مش بتظهر
## الحل كالاتي
- Use the same Cubit instance in PageA and PageB; Like: final PickImgCubit pickImgCubit = PickImgCubit(); 
- Use a BlocProvider.value on the page that you want to [navigate to it], Like: 
  Navigator.push(context, MaterialPageRoute((context) {
    return BlocProvider<PickImgCubit>.value(
      value: pickImgCubit,
      child: const PageB(),
    );
  }));
  hint: PageA without value, but with the same pickImgCubit.
