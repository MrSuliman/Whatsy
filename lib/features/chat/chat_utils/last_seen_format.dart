String lastSeenFormat(lastSeen) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(
      DateTime.fromMillisecondsSinceEpoch(lastSeen),
    );

    String finalMsg = difference.inSeconds > 59
        ? difference.inMinutes > 59
            ? difference.inHours > 23
                ? "${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'}"
                : "${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'}"
            : "${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'}"
        : 'few moments';

    return 'last seen $finalMsg ago';
  }