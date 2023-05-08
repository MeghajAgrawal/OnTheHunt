using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Music : MonoBehaviour
{
    // Start is called before the first frame update
    private AudioSource audioSource;
    GameObject[] MusicSources;
    bool notfirst = false;
    
    public AudioClip firstclip; 
    //public AudioClip secondclip; 
    void Awake()
    {
        MusicSources = GameObject.FindGameObjectsWithTag("Music");
        foreach(GameObject MusicSource in MusicSources)
        {
            if(MusicSource.scene.buildIndex == -1)
            {
                notfirst = true;
            }
        }
        if (notfirst)
        {
            Destroy(this.gameObject);
        }
        DontDestroyOnLoad(transform.gameObject);
        audioSource = GetComponent<AudioSource>();
        audioSource.loop = true;
        StartCoroutine(nameof(PlayMusic));
    }
    
    IEnumerator PlayMusic()
    {
        audioSource.clip = firstclip;
        audioSource.Play();
        yield return new WaitForSeconds(audioSource.clip.length);
        //audioSource.clip = secondclip;
        //audioSource.Play();
    }
    // Update is called once per frame
    public void StopMusic()
    {
        audioSource.Stop();
    }
}
