﻿using System.ComponentModel;

namespace Zenseless.Patterns
{
	internal class PropertyChangedOldValueEventArgs<T> : PropertyChangedEventArgs
	{
		public T OldValue { get; }

		public PropertyChangedOldValueEventArgs(string propertyName, T oldValue) : base(propertyName) => OldValue = oldValue;
	}
}
