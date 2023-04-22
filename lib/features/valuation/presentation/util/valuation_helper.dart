void checkFinalValid(
    {value,
    formKey,
    required Map<String, dynamic> lastValue,
    required Function setState,
    required bool isEdit,
    required bool enableAddAssetButton}) async {
  await Future.delayed(const Duration(milliseconds: 100));
  bool finalValid = formKey.currentState!.isValid;

  Map<String, dynamic> instantValue = formKey.currentState!.instantValue;
  if (finalValid) {
    if (isEdit == true) {
      if (lastValue.toString() != instantValue.toString()) {
        if (!enableAddAssetButton) {
          setState(() {
            enableAddAssetButton = true;
          });
        }
      } else {
        if (enableAddAssetButton) {
          setState(() {
            enableAddAssetButton = false;
          });
        }
      }
    } else {
      if (!enableAddAssetButton) {
        setState(() {
          enableAddAssetButton = true;
        });
      }
    }
  } else {
    if (enableAddAssetButton) {
      setState(() {
        enableAddAssetButton = false;
      });
    }
  }
}
