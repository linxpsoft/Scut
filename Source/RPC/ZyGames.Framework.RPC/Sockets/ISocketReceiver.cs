﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ZyGames.Framework.RPC.Sockets
{
    /// <summary>
    /// Socket接收器
    /// </summary>
    public interface ISocketReceiver
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="remoteAddress"></param>
        /// <param name="buffer"></param>
        /// <returns></returns>
        byte[] Receive(string remoteAddress, byte[] buffer);

    }
}
