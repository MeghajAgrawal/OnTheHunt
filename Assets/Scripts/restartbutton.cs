using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class restartbutton : MonoBehaviour
{
    // Start is called before the first frame update
    public void buttonPress()
    {
        GameObject restart = GameObject.FindGameObjectWithTag("RestartHandler");
        restart.GetComponent<RestartHandler>().restartfunctionality();
    }
}
