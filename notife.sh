#!/bin/bash

now=$(date +"%T")

case "$OSTYPE" in
  darwin*)  
    osascript -e "display notification \"$1\" with title \"🕒 $now\" sound name \"Default\""
    ;;
  linux*)  
    if command -v notify-send &> /dev/null; then
      notify-send -t 5000 "🕒 $now" "$1"
    else
      echo "notify-send is not installed. Please install it to show notifications on Linux."
    fi
    ;;
  msys*|cygwin*|mingw*)
    if command -v powershell.exe &> /dev/null; then
      powershell.exe -Command "[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null; $xml = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText02); $xml.GetElementsByTagName('text').item(0).AppendChild($xml.CreateTextNode('🕒 $now')); $xml.GetElementsByTagName('text').item(1).AppendChild($xml.CreateTextNode('$1')); $toast = [Windows.UI.Notifications.ToastNotification]::new($xml); [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier('notification-call').Show($toast)"
    else
      echo "powershell.exe is not installed. Please install it to show notifications on Windows."
    fi
    ;;
  *)
    echo "Unsupported operating system: $OSTYPE"
    ;;
esac

echo "🕒 $now - $1"