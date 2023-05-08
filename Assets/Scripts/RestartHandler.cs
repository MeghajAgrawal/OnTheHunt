using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class RestartHandler : MonoBehaviour
{
    GameObject[] restarthandler;
    GameObject tutorial;
    bool notfirst = false;
    public static bool restart = false;
    // Start is called before the first frame update
    void Awake()
    {
        restarthandler = GameObject.FindGameObjectsWithTag("RestartHandler");
        foreach(GameObject restart in restarthandler)
        {
            if(restart.scene.buildIndex == -1)
            {
                notfirst = true;
            }
        }
        if (notfirst)
        {
            Destroy(this.gameObject);
        }
        DontDestroyOnLoad(transform.gameObject);
    }
    public void restartfunctionality()
    {
        SceneManager.LoadScene(1);   
        restart = true;
    }

    // Update is called once per frame
    void Update()
    {
        if(restart)
        {
            Time.timeScale = 1;
            HeroKnight.isStart = false;
            tutorial = GameObject.FindGameObjectWithTag("TSpirit");
            tutorial.SetActive(false);
            restart = false;
        }
    }
}
