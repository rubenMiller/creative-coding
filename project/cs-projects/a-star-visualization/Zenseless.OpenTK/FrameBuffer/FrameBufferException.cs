﻿using System;
using System.Runtime.Serialization;

namespace Zenseless.OpenTK
{
	/// <summary>
	/// The exception class for frame buffers.
	/// </summary>
	/// <seealso cref="OpenGLException" />
	[Serializable]
	public class FrameBufferException : OpenGLException
	{
		/// <summary>
		/// Initializes a new instance of the <see cref="FrameBufferException"/> class.
		/// </summary>
		public FrameBufferException()
		{
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="FrameBufferException"/> class.
		/// </summary>
		/// <param name="message">The message that describes the error.</param>
		public FrameBufferException(string message) : base(message)
		{
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="FrameBufferException"/> class.
		/// </summary>
		/// <param name="message">The error message that explains the reason for the exception.</param>
		/// <param name="innerException">The exception that is the cause of the current exception, or a null reference (<see langword="Nothing" /> in Visual Basic) if no inner exception is specified.</param>
		public FrameBufferException(string message, Exception innerException) : base(message, innerException)
		{
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="FrameBufferException"/> class with serialized data.
		/// </summary>
		/// <param name="info">Holds the serialized object data about the exception being thrown.</param>
		/// <param name="context">Contains contextual information about the source or destination.</param>
		protected FrameBufferException(SerializationInfo info, StreamingContext context) : base(info, context)
		{
		}
	}
}