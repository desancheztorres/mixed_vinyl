<?php

declare(strict_types=1);

namespace App\Controller;

use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

use function Symfony\Component\String\u;

final class VinylController
{
    #[Route('/')]
    public function homepage(): Response
    {
        return new Response('Title: PB and Jams');
    }

    #[Route('/browse/{slug}')]
    public function browse(string $slug = null): Response
    {
        if (null === $slug) {
            return new Response('All genre');
        }

        $title = u(str_replace('-', ' ', $slug))->title(true);
        return new Response('Genre: ' . $title);
    }
}
